import { WebPlugin } from '@capacitor/core';
export class IntercomWeb extends WebPlugin {
    constructor() {
        super({
            name: 'Intercom',
            platforms: ['web'],
        });
    }
    async registerIdentifiedUser(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async registerUnidentifiedUser() {
        throw this.unimplemented('Not implemented on web.');
    }
    async updateUser(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async logout() {
        throw this.unimplemented('Not implemented on web.');
    }
    async logEvent(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async displayMessenger() {
        throw this.unimplemented('Not implemented on web.');
    }
    async displayMessageComposer(options) {
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
    async displayCarousel(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async setUserHash(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async setBottomPadding(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    receivePush(notification) {
        notification;
        throw this.unimplemented('Not implemented on web.');
    }
    sendPushTokenToIntercom(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
    async displayArticle(options) {
        options;
        throw this.unimplemented('Not implemented on web.');
    }
}
const Intercom = new IntercomWeb();
export { Intercom };
//# sourceMappingURL=web.js.map
