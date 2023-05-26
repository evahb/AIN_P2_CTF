import json
import random
from collections import deque

import agentspeak as asp
from agentspeak.stdlib import actions as asp_action
from loguru import logger
from numpy import arctan2, cos, sin
from spade.behaviour import OneShotBehaviour, PeriodicBehaviour, CyclicBehaviour
from spade.message import Message
from spade.template import Template
from spade_bdi.bdi import BDIAgent

import random
from pygomas.bditroop import BDITroop
from pygomas.bdifieldop import BDIFieldOp
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions as asp_action
from pygomas.ontology import DESTINATION
from pygomas.agent import LONG_RECEIVE_WAIT

class soldado(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add(".nuevaaccion", 0)
        def _nuevaaccion(agent, term, intention):
        # Codigo

            yield





class capitan(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add(".nuevaaccion", 0)
        def _nuevaaccion(agent, term, intention):
        # Codigo

            yield

        @actions.add(".poscionSoldados", (tuple,))
        def _posicionSoldados(flag):
            # Codigo
            x = flag[0]
            z = flag[0]
            posiciones = []

            for i in [1, -1]:
                for j in [1, -1]:
                    if self.map.can_walk(x + i*30, z + j*30):
                        posiciones.append((x + i*30, 0, z + j*30))
                    else:
                        for k in range(30,70):
                            if self.map.can_walk(x + i*k, z + j*k):
                                posiciones.append((x + i*k, 0, z + j*k))
                                continue
            

            return tuple(posiciones)
    