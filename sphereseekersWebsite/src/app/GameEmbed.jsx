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
        <div className="game-container">
            <iframe
                className="game-embed"
                src="/game/index.html"
                title="Sphereseeker"
            />
        </div>

    );
};

export default GameEmbed;