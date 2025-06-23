import { View, StyleSheet } from 'react-native';
import { Text } from 'react-native';
import { useNetwork } from 'react-native-simple-network-monitor';

export default function App() {
  const data = useNetwork();
  return (
    <View style={styles.container}>
      <Text>Hello World</Text>
      <Text>{JSON.stringify(data)}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
