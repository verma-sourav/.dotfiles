function hex-to-dec
    set hex "$argv[1]"
    python3 -c "print(int('$hex', 16))"
end
