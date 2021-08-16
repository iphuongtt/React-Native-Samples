import React from 'react';
import {createStackNavigator} from '@react-navigation/stack';
import {RootStackParamList} from '@types';
import {HomeScreen} from '@screens';

const RootStack = createStackNavigator<RootStackParamList>();

export const MainNavigator = () => {
  return (
    <RootStack.Navigator initialRouteName="Home">
      <RootStack.Screen name="Home" component={HomeScreen} />
    </RootStack.Navigator>
  );
};

export default MainNavigator;
