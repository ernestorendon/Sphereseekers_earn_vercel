'use client';
import GameEmbed from './GameEmbed';
import {isMobile} from 'react-device-detect';

export default function Page() {

  if (isMobile) {
      return (
        <div className='page'>
          <h1 className='title'>
            Sphereseekers Mobile
          </h1>
          <div className='container'>
            <GameEmbed />
          </div>
        </div>
      );
  }
  return (
    <div className='page'>
      <h1 className='title'>
        Sphereseekers
      </h1>
      <div className='container'>
        <GameEmbed />
      </div>
    </div>
  );
}
