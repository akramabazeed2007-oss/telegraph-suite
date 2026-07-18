# Nova / Telegraph Suite

Prototype and platform scaffold for Nova, a modern social communication app inspired by Telegram, WhatsApp, Discord, Snapchat, and TikTok.

## Contents

- `outputs/telegram-suite.html`: Current interactive browser prototype.
- `outputs/nova-full-app.html`: Expanded Nova full-app prototype with auth, home, chats, groups, channels, calls, reels, profiles, notifications, admin, and AI surfaces.
- `outputs/nova-project-roadmap.md`: Product and architecture roadmap.
- `outputs/nova-database-schema.sql`: PostgreSQL baseline schema.
- `outputs/nova-api-contract.yaml`: Initial API contract.
- `work/nova-platform/backend`: NestJS scaffold and realtime gateway skeleton.
- `work/nova-platform/flutter_app`: Flutter shell scaffold.

## Local Prototype

Run a static server from `outputs` and open:

```text
http://127.0.0.1:4173/telegram-suite.html?v=nova3
```

Expanded Nova prototype:

```text
http://127.0.0.1:4173/nova-full-app.html
```

## Deployment

Static deployment root:

```text
outputs
```

GitHub Pages serves `outputs/index.html`, which redirects to `nova-full-app.html`.

Netlify is configured through `netlify.toml` with `outputs` as the publish directory.

## Development Status

Implemented in this repository:

- Expanded Nova web prototype with login, home, chats, groups, channels, calls, reels, profiles, notifications, admin, and AI surfaces.
- NestJS backend scaffold with controllers for auth, conversations, calls, social features, communities, AI, monetization, and admin.
- Socket.IO realtime gateway skeleton.
- PostgreSQL baseline schema and phase 2 additions.
- Flutter shell scaffold for Android, iOS, and Web migration.

See `outputs/nova-test-plan.md` for the current manual test checklist and backend endpoint map.
