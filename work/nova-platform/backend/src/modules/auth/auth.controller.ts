import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly auth: AuthService) {}

  @Post('guest')
  createGuest() {
    return this.auth.createGuest();
  }

  @Post('phone/start')
  startPhone(@Body() body: { phone: string }) {
    return this.auth.startPhone(body.phone);
  }

  @Post('email/start')
  startEmail(@Body() body: { email: string }) {
    return this.auth.startEmail(body.email);
  }

  @Post('oauth')
  oauth(@Body() body: { provider: 'google' | 'apple'; token: string }) {
    return this.auth.oauth(body.provider, body.token);
  }
}
