from bcn_plot import *
import os.path
pic_path = os.path.abspath('./') + '/'

x = np.array(range(10))
y = np.exp(x)

fig = py.figure()
ax = fig.add_subplot(111)
colors = get_linecolors_from_cubehelix(3)
ax.plot(x, y, color=colors[1])
if (1):
  setfig(ax, xmin=0, xmax=10, ymin=0, ymax=8000,
      xlabel='$\\boldsymbol{N_\\mathrm{accepted}/10^3}$',
      ylabel='relative error [\%]', puff=0.03)
else:
  setfig(ax, xmin=0, xmax=10, ymin=1, ymax=8000,
      xlabel='$\\boldsymbol{N_\\mathrm{accepted}/10^3}$',
      ylabel='relative error [\%]', ylog = True)
ax.text(5,4000, r'\noindent $q\bar{q}\to4g$ \\ \\ $\tau=0.05$')
py.show()
fig.savefig(pic_path + 'test.pdf', dpi=fig.dpi)
