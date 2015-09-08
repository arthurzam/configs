from subprocess import check_output, STDOUT
from time import time

class Py3status:
    cache_timeout = 1

    def brightness(self, i3s_output_list, i3s_config):
        response = {
            'cached_until': time() + self.cache_timeout,
            'full_text': u'☀ ' + check_output(["xbacklight"], stderr=STDOUT).decode("UTF-8").split('.')[0] + '%'
        }

        return response
