function totmp --argument-names 'custom_tag'
    set -l dir_format "totmp.XXXXXX"
    if test -n "$custom_tag"
        set dir_format "totmp-$custom_tag.XXXXXX"
    end

    cd "$(TMPDIR="/tmp" mktemp --tmpdir --directory "$dir_format")"
end
