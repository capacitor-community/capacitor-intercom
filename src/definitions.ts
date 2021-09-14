declare global {
  interface PluginRegistry {
    IntercomPlugin?: IntercomProtocol;
  }
}

export interface IntercomProtocol {
  registerIdentifiedUser(options: {
    userId?: string;
    email?: string;
  }): Promise<void>;
  registerUnidentifiedUser(): Promise<void>;
  updateUser(options: UserUpdateOptions): Promise<void>;
  logout(): Promise<void>;
  logEvent(options: { name: string; data?: any }): Promise<void>;
  displayMessenger(): Promise<void>;
  displayMessageComposer(options: { message: string }): Promise<void>;
  displayHelpCenter(): Promise<void>;
  hideMessenger(): Promise<void>;
  displayLauncher(): Promise<void>;
  hideLauncher(): Promise<void>;
  displayInAppMessages(): Promise<void>;
  hideInAppMessages(): Promise<void>;
  displayCarousel(options: { carouselId: string }): Promise<void>;
  setUserHash(options: { hmac: string }): Promise<void>;
  setBottomPadding(options: { value: string }): Promise<void>;
}

export interface UserUpdateOptions {
  userId?: string;
  email?: string;
  name?: string;
  phone?: string;
  languageOverride?: string;
  customAttributes: { [key: string]: any };
}
