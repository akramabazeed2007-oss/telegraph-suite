# Nova Project Roadmap

Nova is the evolution of the current Telegraph prototype into a global social communication platform combining chat, calls, channels, communities, stories, short video, AI, payments, premium, security, and admin operations.

## Current State

- Existing project: one static HTML prototype at `outputs/telegram-suite.html`.
- Existing features: chats, groups, channels, local message sending, search, pinned messages, scheduled messages, reactions, profile editing, channel/group creation, settings panels.
- Missing for production: Flutter app, NestJS backend, PostgreSQL schema, authentication, realtime transport, media storage, push notifications, moderation, admin dashboard, and deployment/build pipelines.

## Target Architecture

- Frontend: Flutter monorepo app targeting Android, iOS, and Web.
- Backend: NestJS modular API with REST + Socket.IO gateways.
- Database: PostgreSQL with migrations.
- Realtime: WebSocket + Socket.IO rooms for conversations, calls, typing, presence, and live streams.
- Storage: S3-compatible object storage for media, files, vault assets, stories, and short videos.
- Push: Firebase Cloud Messaging.
- AI: provider-agnostic AI service for summaries, translation, reply drafting, transcription, generation, and search.

## Product Modules

1. Identity and accounts
   - Phone, email, Google, Apple, guest login.
   - Guest accounts expire after 30 days.
   - Linking grace period: 15 days after expiry before deletion.
   - Multi-account switching: personal, business, gaming.

2. Messaging
   - Text, images, videos, files, voice notes.
   - Edit, delete, reactions, pinned messages.
   - Scheduled and recurring messages.
   - Full conversation search and live translation.

3. Calls
   - Voice, video, group calls, screen sharing.
   - End-to-end encryption metadata support.
   - AI call summary after completion.

4. Groups and channels
   - Public/private groups and channels.
   - Roles, permissions, topics, polls, tasks, member tags.
   - Channel analytics, scheduled posts, live broadcasts.

5. Status and short video
   - Status posts vanish after 24 hours.
   - Short video feed with like, comment, share, save, recommendation score.

6. Communities
   - Large-scale spaces containing channels, groups, voice rooms, and events.

7. AI assistant
   - Conversation and channel summaries.
   - Reply writing, translation, voice-to-text, post generation, account search.

8. Monetization
   - Nova Stars wallet and ledger.
   - Gifts, post boosts, stream support, cosmetics, colors, badges.
   - Nova Premium entitlements.

9. Privacy and security
   - E2EE-ready conversation model.
   - 2FA, device/session management, anti-spam.
   - Private vault unlocked by PIN/biometric capability.

10. Admin dashboard
   - Users, reports, content, stars, subscriptions, analytics.

## Implementation Phases

### Phase 1: Foundation

- Rebrand the prototype to Nova.
- Add product surface for all modules.
- Create database schema and API contracts.
- Define Flutter screen map and NestJS module map.

### Phase 2: Auth and profile

- Implement auth module.
- Implement guest lifecycle jobs.
- Implement profile, badges, achievements, and multi-account switching.

### Phase 3: Messaging realtime

- Conversations, messages, attachments.
- Socket.IO gateway for typing, presence, reactions, edits, deletes.
- S3 media uploads and message search.

### Phase 4: Social surfaces

- Status, short video, communities, channels, live events.

### Phase 5: AI and monetization

- AI service integration.
- Nova Stars ledger and Premium subscriptions.

### Phase 6: Security and admin

- Vault, 2FA, devices, sessions, spam controls.
- Admin dashboard with analytics and moderation queues.

## Immediate Acceptance Criteria

- Existing chat prototype still works.
- New Nova modules are visible and interactive in the current prototype.
- Architecture files exist for database and API implementation.
- No existing feature is removed.
