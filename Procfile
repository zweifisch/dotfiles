shadow: /usr/local/bin/sslocal -c ~/.shadowsocks.json
ipython: ipython notebook --pylab=inline
pypiworker: sh -c 'cd ~/.pypi-cache && localshop celery worker -B -E'
pypi: sh -c 'cd ~/.pypi-cache && localshop run_gunicorn 0.0.0.0:7000'
