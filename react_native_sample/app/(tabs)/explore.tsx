import { StyleSheet } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { WebView } from "react-native-webview";

export default function TabTwoScreen() {
  return (
    <SafeAreaView style={{ flex: 1 }}>
          <WebView
            style={{ flex: 1 ,marginBottom:40,}}
            source={{
              uri: 'https://allycare-app.rootally.com/',
            }}
            allowsInlineMediaPlayback
            javaScriptEnabled={true}
            injectedJavaScriptBeforeContentLoaded={`
              // Override console.log to send messages to React Native
              (function() {
                const originalLog = console.log;
                console.log = function(...args) {
                  window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'log', data: args }));
                  originalLog.apply(console, args);
                };
              })();
              console.log('Webview Loaded'); // Test log
              true; // Required to return true to indicate the script is valid
            `}
            onMessage={(event) => {
              try {
                const message = JSON.parse(event.nativeEvent.data);
                if (message.type === 'log') {
                  console.log('WebView Log:', ...message.data);
                }
              } catch (error) {
                console.error('Error parsing message from WebView:', error);
              }
            }}
            onNavigationStateChange={(navState) => {
              console.log('Navigation State Change:', navState.url); // Logs URL changes
            }}
          />
        </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  headerImage: {
    color: '#808080',
    bottom: -90,
    left: -35,
    position: 'absolute',
  },
  titleContainer: {
    flexDirection: 'row',
    gap: 8,
  },
});
