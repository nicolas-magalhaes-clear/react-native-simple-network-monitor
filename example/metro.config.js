// metro.config.js
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

module.exports = (async () => {
  try {
    const { getMonorepoConfig } = await import('react-native-monorepo-config');
    const config = getDefaultConfig(__dirname);
    return getMonorepoConfig(config);
  } catch (error) {
    console.warn(
      'react-native-monorepo-config not found, using default config'
    );
    return getDefaultConfig(__dirname);
  }
})();
