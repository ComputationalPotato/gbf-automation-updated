import copy

from utils.settings import Settings
from utils.message_log import MessageLog
from utils.image_utils import ImageUtils
from utils.mouse_utils import MouseUtils
from bot.combat_mode import CombatMode
from bot.window import Window
import json

from typing import List, Dict

class SchedulerException(Exception):
    def __init__(self, message):
        super().__init__(message)


class Scheduler:
    """
    Provides the navigation and any necessary utility functions to handle the Rise of the Beasts game mode.
    """
    mode_name = "Scheduler"

    def _navigate(self, url: str):
        """Navigates to the specified Rise of the Beasts mission.

        Returns:
            None
        """
        from bot.game import Game

        Window.goto_url_tab(url)

        return None

    def print_message(self, message: str):
        MessageLog.print_message(f"\n[{self.mode_name}] {message}")

    # def split_script_into_groups(self, scheduler_script: list, split_by: str = "nextBattle") -> list:
    #     # Early return if there is only 1 schedule
    #     if split_by not in scheduler_script:
    #         return scheduler_script

    #     result = []
    #     grouped_list = []
    #     for ungrouped_script in scheduler_script:
    #         if ungrouped_script not in [split_by, 'endScript']:
    #             grouped_list.append(ungrouped_script)
    #         else:
    #             result.append(grouped_list)
    #             # reset grouped_list
    #             grouped_list = []

    #     return result

    def start(self):
        """Starts the process to complete a run for Rise of the Beasts Farming Mode and returns the number of items detected.

        Args:
            first_run (bool): Flag that determines whether or not to run the navigation process again. Should be False if the Farming Mode supports the "Play Again" feature for repeated runs.

        Returns:
            None
        """
        from bot.game import Game

        loaded_script = copy.deepcopy(Settings.combat_script)
        joined = ''.join(loaded_script)
        json_script: List[Dict] = json.loads(joined)

        for index, script in enumerate(json_script, start=1):
            self.print_message(f"Running script #{index}")
            
            if script.get("comment"):
                self.print_message(f"Starting schedule: {script.get('comment')}")

            max_attempt = script.get('repeat', 1)
            battle_url = script['url']
            summons = script['summons']
            script_command = script.get('combat_script')
            elements = script.get("elements")

            for attempt_num in range(max_attempt):
                self.print_message(f"Goto raid URL")
                self._navigate(url=battle_url)

                Game.wait(1.5)  # delay before summon selection screen popup

                # THIS SECTION IS COPIED FROM raid.py . Might want to refactor the functions next PR
                if ImageUtils.confirm_location("select_a_summon", tries=1):
                    summon_check = Game.select_summon(summons, elements)

                    if summon_check:
                        # Select the Party.
                        if Game.find_party_and_start_mission(Settings.group_number, Settings.party_number):
                            # Handle the rare case where joining the Raid after selecting the Summon and Party led the bot to the Quest Results screen with no loot to collect.
                            if ImageUtils.confirm_location("no_loot", disable_adjustment = True):
                                MessageLog.print_message("\n[RAID] Seems that the Raid just ended. Moving back to the Home screen and joining another Raid...")
                            elif CombatMode.start_combat_mode(script_commands=script_command, use_deep_copy=True):
                                Game.collect_loot(is_completed = True)
                        else:
                            MessageLog.print_message("\n[RAID] Seems that the Raid ended before the bot was able to join. Now looking for another Raid to join...")
                else:
                    if Game.check_for_pending():
                        break

        # for group in grouped_script:
        #     for script in group:
        #         if script.startswith("#"):
        #             self.print_message(f"Starting schedule: {script}")
        #         elif script.startswith("https://"):
        #             self.print_message(f"Goto raid URL")
        #             self._navigate(url=script)


        # # Start the navigation process.
        # if first_run:
        #     Scheduler._navigate()
        # elif Game.find_and_click_button("play_again"):
        #     if Game.check_for_popups():
        #         Scheduler._navigate()
        # else:
        #     # If the bot cannot find the "Play Again" button, check for Pending Battles and then perform navigation again.
        #     Game.check_for_pending()
        #     Scheduler._navigate()

        # # Check for AP.
        # Game.check_for_ap()

        # # Check if the bot is at the Summon Selection screen.
        # if ImageUtils.confirm_location("select_a_summon", tries = 30):
        #     summon_check = Game.select_summon(Settings.summon_list, Settings.summon_element_list)
        #     if summon_check:
        #         # Select the Party.
        #         Game.find_party_and_start_mission(Settings.group_number, Settings.party_number)

        #         # Now start Combat Mode and detect any item drops.
        #         if CombatMode.start_combat_mode():
        #             Game.collect_loot(is_completed = True)
        # else:
        #     raise SchedulerException("Failed to arrive at the Summon Selection screen.")

        return None
