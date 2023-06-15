function noteMiss()
    missSound = string.format('missnote%i', math.random(1, 3));
    playSound(missSound, 0.3);
end

--call the sounds miss1, miss2, and miss3. make sure they are in the mods/sounds folder. fuck around with the script if you know what youre doing. they have to be .ogg files.