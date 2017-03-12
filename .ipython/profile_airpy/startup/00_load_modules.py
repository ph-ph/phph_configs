# copied from https://airbnb.quip.com/HCbCA2CO4fzt
import os
import sys
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('dzmitry_kishylau startup')

try:
    import datetime
    import scipy
    import collections
    from collections import OrderedDict
    import pandas as pd
    import numpy as np
    import matplotlib as mpl
    import matplotlib.pyplot as plt
    plt.ion()
    pd.set_option('display.width', 200)
    pd.set_option('display.max_colwidth', 100)
    pd.set_option('display.max_rows', 500)
    pd.set_option('display.max_seq_items', 500)
    pd.set_option('display.precision', 4)
    pd.set_option('display.max_columns', 500)
except Exception as e:
    logging.error('standard imports failed')
    logging.error(e)
else:
    logger.info('loaded standard imports')

try:
    import airpy as ap
except Exception as e:
    logging.error('Airbnb imports failed')
    logging.error(e)
else:
    logger.info('loaded airbnb imports')
logger.info('Welcome Dima')
