# Returns 0 if the command is available for use. This includes builtins, functions, and external
# programs
function available
    if not set -q argv[1]
        echo "No command was provided"
        return 1
    end

    type -q $argv[1]
end
