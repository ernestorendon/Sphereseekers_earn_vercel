'use client';
import React, { useEffect, useState } from "react";

const GameEmbed = () => {
    const [isMounted, setIsMounted] = useState(false);

    useEffect(() => {
        setIsMounted(true);
    }, []);

    if (!isMounted) {
        return <div>Loading...</div>;
    }

    return (
        <div>
            <iframe 
                className="game-embed"
                src="/game/index.html"
                width="1147px"
                height="630px"
                title="Sphereseeker"
            />
        </div>
    );
};

export default GameEmbed;