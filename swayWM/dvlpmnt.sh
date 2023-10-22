export JAVA_HOME="$HOME/dvlpmnt/env/java"
export RUSTUP_HOME="$HOME/dvlpmnt/env/rust/rustup"
export CARGO_HOME="$HOME/dvlpmnt/env/rust/cargo"
case ":${PATH}:" in
    *:"${HOME}/dvlpmnt/env/java/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
	export PATH="$JAVA_HOME/bin:$PATH"
        ;;
esac
case ":${PATH}:" in
    *:"${HOME}/dvlpmnt/env/rust/cargo/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed rustc needs to be overridden
	export PATH="$CARGO_HOME/bin:$PATH"
        ;;
esac

