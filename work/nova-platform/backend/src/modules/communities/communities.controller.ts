import { Body, Controller, Get, Post } from '@nestjs/common';

@Controller('communities')
export class CommunitiesController {
  @Get()
  list() {
    return [
      { id: 'nova-devs', name: 'Nova Devs', channels: 4, groups: 12, voiceRooms: 2, events: 3 },
    ];
  }

  @Post()
  create(@Body() body: { name: string; visibility: 'public' | 'private' }) {
    return { id: crypto.randomUUID(), ...body, channels: [], groups: [], voiceRooms: [], events: [] };
  }
}
