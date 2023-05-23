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

from .agent import AbstractAgent, LONG_RECEIVE_WAIT
from .config import (
    Config,
    MIN_POWER,
    MAX_POWER,
    POWER_UNIT,
    MIN_STAMINA,
    MAX_STAMINA,
    STAMINA_UNIT,
    MIN_AMMO,
    MAX_AMMO,
    MIN_HEALTH,
    MAX_HEALTH,
    TEAM_NONE,
    TEAM_ALLIED,
    TEAM_AXIS,
    PRECISION_Z,
    PRECISION_X,
)
from .jps import JPSAlgorithm
from .map import TerrainMap
from .mobile import Mobile
from .ontology import (
    AIM,
    ANGLE,
    DEC_HEALTH,
    DISTANCE,
    FOV,
    HEAD_X,
    HEAD_Y,
    HEAD_Z,
    MAP,
    PACKS,
    QTY,
    SHOTS,
    VEL_X,
    TYPE,
    VEL_Y,
    VEL_Z,
    X,
    Y,
    Z,
    PERFORMATIVE,
    PERFORMATIVE_CFA,
    PERFORMATIVE_CFB,
    PERFORMATIVE_CFM,
    PERFORMATIVE_DATA,
    PERFORMATIVE_GAME,
    PERFORMATIVE_GET,
    PERFORMATIVE_INIT,
    PERFORMATIVE_MOVE,
    PERFORMATIVE_OBJECTIVE,
    PERFORMATIVE_SHOOT,
    AMMO_SERVICE,
    BACKUP_SERVICE,
    MEDIC_SERVICE,
    AMMO,
    BASE,
    CLASS,
    DESTINATION,
    ENEMIES_IN_FOV,
    FRIENDS_IN_FOV,
    FLAG,
    HEADING,
    HEALTH,
    NAME,
    MY_MEDICS,
    MY_FIELDOPS,
    MY_BACKUPS,
    PACKS_IN_FOV,
    PERFORMATIVE_PACK_TAKEN,
    PERFORMATIVE_TARGET_REACHED,
    PERFORMATIVE_FLAG_TAKEN,
    POSITION,
    TEAM,
    THRESHOLD_HEALTH,
    THRESHOLD_AMMO,
    THRESHOLD_AIM,
    THRESHOLD_SHOTS,
    VELOCITY,
)
from .pack import PACK_MEDICPACK, PACK_AMMOPACK, PACK_OBJPACK, PACK_NONE
from .sight import Sight
from .threshold import Threshold
from .vector import Vector3D


from pygomas.bditroop import BDITroop

class newSoldier(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add(".nuevaaccion", 0)
        def_nuevaacion(agent, term, intention):
        # Codigo

        yield