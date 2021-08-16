import React from 'react';
import {
  View,
  SafeAreaView,
  Image,
  StyleSheet,
  useWindowDimensions,
} from 'react-native';
import {DemoButton, DemoResponse} from '../components/ui';
import * as ImagePicker from 'react-native-image-picker';
import {ImagePickerResponse} from 'react-native-image-picker/src/types';

import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '@types';

type HomeScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Home'>;
type HomeScreenRouteProp = RouteProp<RootStackParamList, 'Home'>;

type Props = {
  route: HomeScreenRouteProp;
  navigation: HomeScreenNavigationProp;
};

export const HomeScreen = (props: Props) => {
  const {navigation} = props;
  const {width} = useWindowDimensions();
  const [response, setResponse] = React.useState<ImagePickerResponse | null>(
    null,
  );

  const onButtonPress = React.useCallback((type, options) => {
    console.log({type, options});
    if (type === 'capture') {
      ImagePicker.launchCamera(options, setResponse);
    } else {
      ImagePicker.launchImageLibrary(options, setResponse);
    }
  }, []);

  const onProcessImage = () => {
    if (response) {
      navigation.navigate('ProcessImage', {
        uri: response?.assets?.[0]?.uri!!,
      });
    }
  };

  return (
    <View style={{flex: 1}}>
      <SafeAreaView style={{flex: 1, flexDirection: 'column-reverse'}}>
        <View style={{flexDirection: 'row', paddingBottom: 8}}>
          <DemoButton key="Process Image" onPress={onProcessImage}>
            {'Process Image'}
          </DemoButton>
        </View>
        <View style={{flexDirection: 'row', paddingVertical: 8}}>
          <DemoButton
            key="Take Image"
            onPress={() =>
              onButtonPress('capture', {
                saveToPhotos: true,
                mediaType: 'photo',
                includeBase64: false,
              })
            }>
            {'Take Image'}
          </DemoButton>
          <DemoButton
            key="Select Image"
            onPress={() =>
              onButtonPress('library', {
                selectionLimit: 0,
                mediaType: 'photo',
                includeBase64: false,
              })
            }>
            {'Select Image'}
          </DemoButton>
        </View>
        <View style={{paddingHorizontal: 8}}>
          <DemoResponse>{response}</DemoResponse>
        </View>
        {response?.assets &&
          response?.assets.map(({uri}) => (
            <View key={uri} style={styles.image}>
              <Image
                resizeMode="cover"
                resizeMethod="scale"
                style={{width, height: width}}
                source={{uri: uri}}
              />
            </View>
          ))}
      </SafeAreaView>
    </View>
  );
};

const styles = StyleSheet.create({
  image: {
    marginVertical: 24,
    alignItems: 'center',
  },
});

export default HomeScreen;
