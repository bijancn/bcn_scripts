import matplotlib.pyplot as plt
import numpy as np
from matplotlib._cm import cubehelix
from matplotlib.ticker import AutoMinorLocator, ScalarFormatter

# Valid legend locations
# right         # center left   # upper right    # lower right   # best
# center        # lower left    # center right   # upper left    # upper center
# lower center

class Plotter(object):
  def __init__(self):
    self.title_notset = True

  def setfig(self, ax, xmin, xmax, ymin, ymax, xlabel, ylabel,
      title=None, xlog=False, ylog=False, xminors=False, yminors=False,
      n_minors=5, xticks=None, yticks=None, puff=0.05, legend_location='best',
      legend_columns=1, legend_outside=False, legend_resizer=0.80,
      legend_hide=False, legend_ordering=[]):
    # label axes and set ranges and scales
    if xlabel is not None:
      ax.set_xlabel(xlabel)
    if ylabel is not None:
      ax.set_ylabel(ylabel)
    _set_puffed_scale(puff, xmax, xmin, xlog, ax.set_xlim, ax.set_xscale)
    _set_puffed_scale(puff, ymax, ymin, ylog, ax.set_ylim, ax.set_yscale)

    # title (ensuring no double set)
    if title is not None and self.title_notset:
      plt.suptitle(title, y=0.99)
      #plt.text(0.7, 1.01, title,
         #horizontalalignment='center',
         #transform = ax.transAxes)
      self.title_notset = False

    # tight layout with extra padding
    # pad : padding between the figure edge and the edges of subplots, as a
    #       fraction of the font-size
    # h_pad, w_pad : padding (height/width) between edges of adjacent subplots.
    #                Defaults to pad_inches
    #rect : if rect is given, it is interpreted as a rectangle
    #       (left, bottom, right, top) in the normalized figure coordinate that
    #       the whole subplots area (including labels) will fit into.
    #       Default is (0, 0, 1, 1)
    #       We set top to 0.96 to have space for title
    plt.tight_layout(pad=0.5, rect=[0, 0.00, 1, 0.96])

    # major ticks
    if xticks is not None:
      ax.set_xticks(xticks)
    if yticks is not None:
      ax.set_yticks(yticks)

    # minor ticks are auto-set to n_minors if requested
    minorLocator = AutoMinorLocator(n_minors)
    if xminors:
      ax.xaxis.set_minor_locator(minorLocator)
    if yminors:
      ax.yaxis.set_minor_locator(minorLocator)
    #plt.tick_params(which='both', width=2)
    #plt.tick_params(which='major', length=7)

    # This should allow to use scientific format of logarithmic scale with 10^X
    # above the axe.
    #formatter = ScalarFormatter(useMathText=True)
    #formatter.set_scientific(True)
    #formatter.set_powerlimits((-1,1))
    #ax.yaxis.set_major_formatter(formatter)

    # legend
    if not legend_hide:
      handles, labels = ax.get_legend_handles_labels()
      # reorder if fitting sequence is given
      if len(legend_ordering) == len(handles):
        handles = map(handles.__getitem__, legend_ordering)
        labels = map(labels.__getitem__, legend_ordering)
      if legend_outside:
        # Shrink current axis's height by (1.0-legend_resizer) on the bottom
        box = ax.get_position()
        ax.set_position([box.x0, box.y0 + box.height * (1.0-legend_resizer),
                         box.width, box.height * legend_resizer])
        # Put a legend below current axis
        ax.legend(handles, labels, loc='upper center',
            bbox_to_anchor=(0.5, -(1.0-legend_resizer)/2),
            fancybox=False, ncol=legend_columns)
      else:
        ax.legend(handles, labels, loc=legend_location,
                  fancybox=False, ncol=legend_columns)


def get_linecolors_from_cubehelix(N, gamma=0.8, hue=3.0, rot=1.8, start=-0.30):
  """Return N colors from the cubehelix for plots
  """
  rgb_dict = cubehelix(h=hue, r=rot, gamma=gamma, s=start)
  brightness = np.linspace(0.0, 1.0, num=N, endpoint=False)
  rgb_list = [(rgb_dict['red'](b), rgb_dict['green'](b),
              rgb_dict['blue'](b)) for b in brightness]
  ret = [(_norm(a), _norm(b), _norm(c)) for a, b, c in rgb_list]
  return ret

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
