-- Nova PostgreSQL baseline schema
-- This is the first production-oriented data model for the current prototype.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE auth_provider AS ENUM ('phone', 'email', 'google', 'apple', 'guest');
CREATE TYPE account_type AS ENUM ('personal', 'business', 'gaming');
CREATE TYPE conversation_type AS ENUM ('direct', 'group', 'channel', 'community_room');
CREATE TYPE visibility_type AS ENUM ('public', 'private', 'invite_only');
CREATE TYPE media_type AS ENUM ('image', 'video', 'audio', 'file');
CREATE TYPE message_status AS ENUM ('sent', 'delivered', 'read', 'deleted');
CREATE TYPE subscription_tier AS ENUM ('free', 'premium');
CREATE TYPE report_status AS ENUM ('open', 'reviewing', 'resolved', 'rejected');

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  display_name VARCHAR(120) NOT NULL,
  username VARCHAR(64) UNIQUE,
  phone VARCHAR(32) UNIQUE,
  email VARCHAR(255) UNIQUE,
  avatar_url TEXT,
  intro_video_url TEXT,
  bio TEXT,
  favorite_music TEXT,
  is_guest BOOLEAN NOT NULL DEFAULT FALSE,
  guest_expires_at TIMESTAMPTZ,
  guest_link_deadline_at TIMESTAMPTZ,
  subscription_tier subscription_tier NOT NULL DEFAULT 'free',
  two_factor_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE auth_identities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  provider auth_provider NOT NULL,
  provider_subject VARCHAR(255),
  verified_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(provider, provider_subject)
);

CREATE TABLE user_accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type account_type NOT NULL,
  label VARCHAR(120) NOT NULL,
  color_hex VARCHAR(12),
  active BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE devices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(160) NOT NULL,
  platform VARCHAR(64) NOT NULL,
  push_token TEXT,
  last_seen_at TIMESTAMPTZ,
  revoked_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE communities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  owner_id UUID NOT NULL REFERENCES users(id),
  name VARCHAR(160) NOT NULL,
  slug VARCHAR(80) UNIQUE NOT NULL,
  description TEXT,
  visibility visibility_type NOT NULL DEFAULT 'public',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE conversations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  type conversation_type NOT NULL,
  community_id UUID REFERENCES communities(id) ON DELETE SET NULL,
  owner_id UUID REFERENCES users(id) ON DELETE SET NULL,
  title VARCHAR(180),
  slug VARCHAR(100),
  description TEXT,
  visibility visibility_type NOT NULL DEFAULT 'private',
  e2ee_enabled BOOLEAN NOT NULL DEFAULT TRUE,
  live_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE conversation_members (
  conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role VARCHAR(64) NOT NULL DEFAULT 'member',
  permissions JSONB NOT NULL DEFAULT '{}',
  muted_until TIMESTAMPTZ,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (conversation_id, user_id)
);

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
  sender_id UUID REFERENCES users(id) ON DELETE SET NULL,
  reply_to_id UUID REFERENCES messages(id) ON DELETE SET NULL,
  body TEXT,
  translated_body JSONB NOT NULL DEFAULT '{}',
  status message_status NOT NULL DEFAULT 'sent',
  pinned BOOLEAN NOT NULL DEFAULT FALSE,
  scheduled_for TIMESTAMPTZ,
  recurring_rule TEXT,
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE message_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  type media_type NOT NULL,
  storage_key TEXT NOT NULL,
  mime_type VARCHAR(120),
  size_bytes BIGINT NOT NULL DEFAULT 0,
  duration_ms INTEGER,
  width INTEGER,
  height INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE message_reactions (
  message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  emoji VARCHAR(32) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (message_id, user_id, emoji)
);

CREATE TABLE calls (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  conversation_id UUID REFERENCES conversations(id) ON DELETE SET NULL,
  started_by UUID REFERENCES users(id) ON DELETE SET NULL,
  is_video BOOLEAN NOT NULL DEFAULT FALSE,
  is_group BOOLEAN NOT NULL DEFAULT FALSE,
  screen_share_enabled BOOLEAN NOT NULL DEFAULT FALSE,
  e2ee_enabled BOOLEAN NOT NULL DEFAULT TRUE,
  ai_summary TEXT,
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at TIMESTAMPTZ
);

CREATE TABLE status_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  caption TEXT,
  media_url TEXT,
  music_title VARCHAR(180),
  poll JSONB,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE short_videos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  video_url TEXT NOT NULL,
  caption TEXT,
  recommendation_score NUMERIC(10, 4) NOT NULL DEFAULT 0,
  like_count INTEGER NOT NULL DEFAULT 0,
  comment_count INTEGER NOT NULL DEFAULT 0,
  share_count INTEGER NOT NULL DEFAULT 0,
  save_count INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE nova_star_wallets (
  user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  balance BIGINT NOT NULL DEFAULT 0,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE nova_star_transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount BIGINT NOT NULL,
  reason VARCHAR(120) NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE vault_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type media_type NOT NULL,
  storage_key TEXT NOT NULL,
  encrypted BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  reporter_id UUID REFERENCES users(id) ON DELETE SET NULL,
  target_type VARCHAR(80) NOT NULL,
  target_id UUID NOT NULL,
  reason TEXT NOT NULL,
  status report_status NOT NULL DEFAULT 'open',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ
);

CREATE INDEX idx_messages_conversation_created ON messages(conversation_id, created_at DESC);
CREATE INDEX idx_conversations_type ON conversations(type);
CREATE INDEX idx_short_videos_score ON short_videos(recommendation_score DESC, created_at DESC);
CREATE INDEX idx_status_posts_expires ON status_posts(expires_at);
CREATE INDEX idx_reports_status ON reports(status);
