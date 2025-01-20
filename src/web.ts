import { WebPlugin } from '@capacitor/core';

import type { IntercomPlugin, IntercomPushNotificationData, IntercomUserUpdateOptions } from './definitions';

export class IntercomWeb extends WebPlugin implements IntercomPlugin {
  constructor() {
    super({
      name: 'Intercom',
      platforms: ['web'],
    });
  }

  async registerIdentifiedUser(options: { userId?: string; email?: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async loadWithKeys(options: { appId?: string; apiKeyIOS?: string; apiKeyAndroid?: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async registerUnidentifiedUser(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async updateUser(options: IntercomUserUpdateOptions): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async logout(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async logEvent(options: { name: string; data?: any }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async displayMessenger(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayMessageComposer(options: { message: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async displayHelpCenter(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideMessenger(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayLauncher(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideLauncher(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayInAppMessages(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideInAppMessages(): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayCarousel(options: { carouselId: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async setUserHash(options: { hmac: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async setBottomPadding(options: { value: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  receivePush(notification: IntercomPushNotificationData): Promise<void> {
    notification;
    throw this.unimplemented('Not implemented on web.');
  }

  sendPushTokenToIntercom(options: { value: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async displayArticle(options: { articleId: string }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }
}

const Intercom = new IntercomWeb();

export { Intercom };
