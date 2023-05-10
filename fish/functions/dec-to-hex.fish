function dec-to-hex
    set decimal "$argv[1]"
    python3 -c "print(hex($decimal))"
end
