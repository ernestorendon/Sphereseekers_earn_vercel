'use client';
import GameEmbed from './GameEmbed';
import {isMobile} from 'react-device-detect';

export default function Page() {
  return (
    <div className='page'>
      <div className='container'>
        <GameEmbed />
      </div>
    </div>
  )
}
