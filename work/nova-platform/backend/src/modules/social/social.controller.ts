import { Body, Controller, Get, Post } from '@nestjs/common';

@Controller()
export class SocialController {
  @Get('clips')
  clips() {
    return [
      { id: 'clip-1', caption: 'Nova Reel', score: 98.4, liked: false, saved: false },
      { id: 'clip-2', caption: 'Community Live', score: 91.1, liked: true, saved: true },
    ];
  }

  @Post('clips')
  createClip(@Body() body: { caption: string; videoUrl: string }) {
    return { id: crypto.randomUUID(), ...body, recommendationScore: 0 };
  }

  @Post('status')
  createStatus(@Body() body: { caption: string; mediaUrl?: string }) {
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);
    return { id: crypto.randomUUID(), ...body, expiresAt };
  }
}
