/**
 * [Q4] Fix the memory leak issue in below method
 * 
 * Muhammad Naufal Pratama
 * 
 * The Game::addItemToPlayer method is suppose to add an item with itemId to a player
 * This method contains a memory leaks where we call "new" on a raw pointer, but no "delete" has been call
 * To fix this, I change the raw pointer into a smart pointer, so that the RAII or deallocation process will be done automatically by the smart pointer
*/

#include <memory>                                                               // shared_ptr

void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    std::shared_ptr<Player> player = g_game.getPlayerByName(recipient);         // use shared_ptr to handle the RAII easyly
                                                                                // if we use a raw pointer and
                                                                                // create the Player object using "new" keyword,
                                                                                // we need to make sure do deallocate using "delete",
                                                                                // but this program has an if-else statement that made 
                                                                                // the deallocation process harder
    if (player != nullptr)
    {
        player = std::make_shared<Player> (new Player(nullptr));                // When the player goes out of scope, the deallocation would be done by shared_ptr
        if (!IOLoginData::loadPlayerByName(player, recipient))                  // this if-else is tricky. If we create "new" Player object, and then call loadPlayerByName()
        {                                                                       // but turns out that the call is failed, it will go inside this if-else and return from this function
            return;                                                             // but we haven't deallocate the "new" Player object yet using "delete"
        }                                                                       // so for easier implementation, I change raw pointer to use shared_ptr
    } else {                                            
        return;                                                                 // if player is null, nothing much we can don in this function, so I just return
    }

    Item *item = Item::CreateItem(itemId);
    if (item == nullptr)                                                        // if CreateItem is failed and so the item is null, nothing we can do anymore, so just return
    {
        return; 
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }
}

int main()
{
    Game game{};
    game.addItemToPlayer("player1", 123);

    return 0;
}
