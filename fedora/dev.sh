export JAVA_HOME="$HOME/dev/env/java"
export RUSTUP_HOME="$HOME/dev/env/rust/rustup"
export CARGO_HOME="$HOME/dev/env/rust/cargo"
case ":${PATH}:" in
    *:"${HOME}/dev/env/java/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
	export PATH="$JAVA_HOME/bin:$PATH"
        ;;
esac
case ":${PATH}:" in
    *:"${HOME}/dev/env/rust/cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
	export PATH="$CARGO_HOME/bin:$PATH"
        ;;
esac

