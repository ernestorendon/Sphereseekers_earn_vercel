'use client';
import GameEmbed from './GameEmbed';

export default function Page() {
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
