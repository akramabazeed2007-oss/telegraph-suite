import { Module } from '@nestjs/common';
import { AdminModule } from './modules/admin/admin.module';
import { AiModule } from './modules/ai/ai.module';
import { AuthModule } from './modules/auth/auth.module';
import { CallsModule } from './modules/calls/calls.module';
import { CommunitiesModule } from './modules/communities/communities.module';
import { ConversationsModule } from './modules/conversations/conversations.module';
import { MonetizationModule } from './modules/monetization/monetization.module';
import { ProfilesModule } from './modules/profiles/profiles.module';
import { SocialModule } from './modules/social/social.module';
import { VaultModule } from './modules/vault/vault.module';
import { NovaGateway } from './realtime/nova.gateway';

@Module({
  imports: [
    AuthModule,
    ProfilesModule,
    ConversationsModule,
    CallsModule,
    CommunitiesModule,
    SocialModule,
    AiModule,
    MonetizationModule,
    VaultModule,
    AdminModule,
  ],
  providers: [NovaGateway],
})
export class AppModule {}
