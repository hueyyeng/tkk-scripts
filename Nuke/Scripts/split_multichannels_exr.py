# Repurpose from http://www.muttsy.net/blog/2011/10/20/shuffle-out-all-channels/
"""Split/shuffle Multichannel EXRs

Splits multichannel EXRs using Shuffle node that shuffles every layers into RGBA.

"""
import nuke


def split_multichannels_exr():
    nodes = nuke.selectedNodes()
    for node in nodes:
        if node.Class() == 'Read':
            channels = node.channels()
            layers = list( set([channel.split('.')[0] for channel in channels]) )
            layers.sort()
            if 'rgba' in layers:
                layers.remove('rgba')
            for layer in layers:
                shuffleNode = nuke.nodes.Shuffle(label=layer,inputs=[node])
                shuffleNode['in'].setValue( layer )
                shuffleNode['postage_stamp'].setValue(True)
        else:
            pass
            
split_multichannels_exr()
