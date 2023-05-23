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

class agente(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add(".nuevaaccion", 0)
        def _nuevaaccion(agent, term, intention):
        # Codigo

        yield