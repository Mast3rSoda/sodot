if [ -z "$DISPLAY" ]; then
	if uwsm check may-start && uwsm select; then
		DEBUG=1 exec uwsm start default
	fi
fi
