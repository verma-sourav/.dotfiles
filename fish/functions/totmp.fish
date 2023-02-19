function totmp
    set rand_length 5
    set rand_val (LC_ALL=C tr -dc [:alnum:] </dev/urandom | head -c "$rand_length")
    set temp_dir "/tmp/totmp.$rand_val"
    mkdir "$temp_dir"
    cd "$temp_dir"
end
