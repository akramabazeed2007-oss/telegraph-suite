import { Body, Controller, Get, Post } from '@nestjs/common';

@Controller()
export class MonetizationController {
  @Get('stars/wallet')
  wallet() {
    return { balance: 12450, currency: 'NOVA_STARS' };
  }

  @Post('stars/transfer')
  transfer(@Body() body: { toUserId: string; amount: number; reason: string }) {
    return { id: crypto.randomUUID(), ...body, status: 'posted' };
  }

  @Post('premium/checkout')
  checkout() {
    return { checkoutId: crypto.randomUUID(), tier: 'premium', status: 'created' };
  }
}
