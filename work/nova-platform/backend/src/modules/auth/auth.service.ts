import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  createGuest() {
    const now = new Date();
    const expiresAt = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000);
    const linkDeadlineAt = new Date(expiresAt.getTime() + 15 * 24 * 60 * 60 * 1000);
    return {
      userId: crypto.randomUUID(),
      mode: 'guest',
      expiresAt,
      linkDeadlineAt,
      token: 'dev.guest.token',
    };
  }

  startPhone(phone: string) {
    return { channel: 'phone', destination: phone, status: 'otp_sent' };
  }

  startEmail(email: string) {
    return { channel: 'email', destination: email, status: 'verification_sent' };
  }

  oauth(provider: 'google' | 'apple', token: string) {
    return { provider, tokenPreview: token.slice(0, 8), status: 'accepted' };
  }
}
