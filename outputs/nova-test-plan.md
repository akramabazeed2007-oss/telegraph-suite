# Nova Test Plan

## Prototype URL

Run a static server from `outputs`:

```powershell
python -m http.server 4173 --bind 127.0.0.1
```

Open:

```text
http://127.0.0.1:4173/nova-full-app.html
```

## Manual Test Checklist

- Login screen:
  - Phone tab changes the input label.
  - Email tab changes the input label.
  - Guest login hides the auth screen and opens the guest account notice.

- Home:
  - Shows Nova platform cards.
  - Sidebar search filters conversations.

- Conversations:
  - Select a direct chat, group, or channel.
  - Send a message from the composer.
  - Use quick inserts: file, image, voice, poll, translation, schedule, recurring.

- Calls:
  - Open Calls from navigation.
  - Trigger voice, video, and screen-share buttons.

- Reels:
  - Open Reels from navigation.
  - Confirm video cards for like/comment/share/save surface.

- Profiles:
  - Open Profiles.
  - Confirm profile video, achievements, rewards, and badges.

- Notifications:
  - Open notifications from the bottom rail.

- Admin:
  - Open admin dashboard.
  - Confirm users, reports, content, stars, subscriptions, and analytics cards.

## Backend Surface

The NestJS scaffold has controllers for:

- `POST /api/v1/auth/guest`
- `POST /api/v1/auth/phone/start`
- `POST /api/v1/auth/email/start`
- `POST /api/v1/auth/oauth`
- `GET /api/v1/conversations`
- `POST /api/v1/conversations`
- `GET /api/v1/conversations/:id/messages`
- `POST /api/v1/conversations/:id/messages`
- `POST /api/v1/calls`
- `POST /api/v1/calls/:id/summary`
- `GET /api/v1/clips`
- `POST /api/v1/clips`
- `POST /api/v1/status`
- `GET /api/v1/communities`
- `POST /api/v1/communities`
- `POST /api/v1/ai/summarize`
- `POST /api/v1/ai/translate`
- `GET /api/v1/stars/wallet`
- `POST /api/v1/stars/transfer`
- `POST /api/v1/premium/checkout`
- `GET /api/v1/admin/dashboard`
- `GET /api/v1/admin/reports`

## Database

Apply the baseline schema first:

```text
outputs/nova-database-schema.sql
```

Then apply phase 2 additions:

```text
outputs/nova-phase2-database-additions.sql
```

## Current Limitations

- Backend is scaffolded and typed, but dependencies have not been installed in this environment.
- Flutter shell is a starter map, not a fully built production app yet.
- The current fully interactive test target is the static web prototype.
