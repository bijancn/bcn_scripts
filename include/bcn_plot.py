import matplotlib.pyplot as plt
import numpy as np
from matplotlib._cm import cubehelix
from matplotlib.ticker import AutoMinorLocator

# Valid legend locations
# right
# center left
# upper right
# lower right
# best
# center
# lower left
# center right
# upper left
# upper center
# lower center

def setfig(ax, xmin, xmax, ymin, ymax, xlabel, ylabel, title=None, puff=0.05,
    xlog=False, ylog=False, xminors=False, yminors=False,
    xticks=None, yticks=None, n_minors=5, legend_location='best',
    legend_columns=1, legend_outside=True, legend_resizer=0.77):
  plt.xlabel(xlabel)
  plt.ylabel(ylabel)
  _set_puffed_scale(puff, xmax, xmin, xlog, ax.set_xlim, plt.xscale)
  _set_puffed_scale(puff, ymax, ymin, ylog, ax.set_ylim, plt.yscale)

  # title
  if title:
    plt.title(title, y=1.02)

  # extra padding around the figure border and between subplots
  #pad : float
  #padding between the figure edge and the edges of subplots, as a fraction of the font-size.
  #h_pad, w_pad : float
  #padding (height/width) between edges of adjacent subplots. Defaults to pad_inches.
  #rect : if rect is given, it is interpreted as a rectangle
  #(left, bottom, right, top) in the normalized figure coordinate that the whole
  #subplots area (including labels) will fit into. Default is (0, 0, 1, 1).
  plt.tight_layout(pad=1.0, rect = (0,0,1,1))

  # minors
  minorLocator   = AutoMinorLocator(n_minors)
  if xminors:
    ax.xaxis.set_minor_locator(minorLocator)
  if yminors:
    ax.yaxis.set_minor_locator(minorLocator)
  #plt.tick_params(which='both', width=2)
  #plt.tick_params(which='major', length=7)
  #plt.tick_params(which='minor', length=4, color='r')

  # ticks
  if xticks is not None:
    plt.xticks(xticks)
  if yticks is not None:
    plt.yticks(yticks)

  # legend
  if legend_outside:
    # Shrink current axis's height by (1.0-legend_resizer) on the bottom
    box = ax.get_position()
    ax.set_position([box.x0, box.y0 + box.height * (1.0-legend_resizer),
                     box.width, box.height * legend_resizer])
    # Put a legend below current axis
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, -(1.0-legend_resizer)/2),
              fancybox=False, ncol=legend_columns)
  else:
    ax.legend(loc=legend_location,
              fancybox=False, ncol=legend_columns)


def _set_puffed_scale(puff, smax, smin, slog, ax_set_slim, ax_set_sscale):
  if slog:
    puffs = puff * np.log(smax-smin)
    ax_set_slim(np.exp(np.log(smin) - puffs),
                np.exp(np.log(smax) + puffs))
    ax_set_sscale('log')
  else:
    puffx = puff * (smax - smin)
    ax_set_slim(smin - puffx, smax + puffx)

def _norm(x):
  if (x>1.0):
    return 1.0
  if (x<0.0):
    return 0.0
  return x

def get_linecolors_from_cubehelix(N, gamma=0.8, hue=3.5, rot=1.5, start=0.45):
  """Return N colors from the cubehelix for plots
  """
  rgb_dict = cubehelix(h=hue, r=rot, gamma=gamma)
  rgb_dict = cubehelix(h=hue, r=rot, gamma=gamma, s=start)
  brightness = np.linspace(0.0, 1.0, num=N, endpoint=False)
  rgb_list = [(rgb_dict['red'](b), rgb_dict['green'](b),
              rgb_dict['blue'](b)) for b in brightness]
  ret = [(_norm(a), _norm(b), _norm(c)) for a, b, c in rgb_list]
  return ret
