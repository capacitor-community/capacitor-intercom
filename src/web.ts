import { WebPlugin } from '@capacitor/core';
import { IntercomPlugin, IntercomPushNotificationData, IntercomUserUpdateOptions } from './definitions';
export class IntercomWeb extends WebPlugin implements IntercomPlugin {
  constructor() {
    super({
      name: 'Intercom',
      platforms: ['web'],
    });
  }

  async registerIdentifiedUser(options: { userId?: string; email?: string }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async loadWithKeys(options: { appId?: string; apiKeyIOS?: string; apiKeyAndroid?: string; }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async registerUnidentifiedUser() {
    throw this.unimplemented('Not implemented on web.');
  }

  async updateUser(options: IntercomUserUpdateOptions) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async logout() {
    throw this.unimplemented('Not implemented on web.');
  }

  async logEvent(options: { name: string; data?: any }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async displayMessenger() {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayMessageComposer(options: { message: string }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async displayHelpCenter() {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideMessenger() {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayLauncher() {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideLauncher() {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayInAppMessages() {
    throw this.unimplemented('Not implemented on web.');
  }

  async hideInAppMessages() {
    throw this.unimplemented('Not implemented on web.');
  }

  async displayCarousel(options: { carouselId: string }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async setUserHash(options: { hmac: string }) {
    options;
    throw this.unimplemented('Not implemented on web.');
  }

  async setBottomPadding(options: { value: string }) {
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

  async displayArticle(options: { articleId: string; }): Promise<void> {
    options;
    throw this.unimplemented('Not implemented on web.');
  }
}

const Intercom = new IntercomWeb();

export { Intercom };
