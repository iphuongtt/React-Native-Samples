import React from 'react';
import {enableScreens} from 'react-native-screens';
import 'react-native-gesture-handler';
import {AppNavigator} from '@navigators';

enableScreens();

export default function App() {
  return <AppNavigator />;
}
