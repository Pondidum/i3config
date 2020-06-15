import sys

from openrazer.client import DeviceManager
from openrazer.client import constants as razer_constants

dm = DeviceManager()
dm.sync_effects = False

for dv in dm.devices:
    if sys.argv[1] == "lock":
        dv.fx.starlight_random(razer_constants.STARLIGHT_SLOW)
    else:
        dv.fx.reactive(255, 0, 0, razer_constants.REACTIVE_1000MS)
