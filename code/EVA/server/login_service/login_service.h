#ifndef NL_LOGIN_SERVICE_H
#define NL_LOGIN_SERVICE_H

// we have to include windows.h because mysql.h uses it but not include it
#ifdef NL_OS_WINDOWS
#	define NOMINMAX
#	include <windows.h>
#endif

#include "nel/misc/types_nl.h"

#include "nel/misc/debug.h"
#include "nel/misc/config_file.h"
#include "nel/misc/displayer.h"
#include "nel/misc/log.h"

#include "nel/net/service.h"

#include <server_share/msg_struct/msg_struct_login.h>

using namespace std;
using namespace NLMISC;
using namespace NLNET;

// Structures



//struct CShard
//{
//	CShard (uint32 shardId, TServiceId sid) : ShardId(shardId), NbPlayers(0), SId(sid) {}
//	
//	sint32	ShardId;	// unique shard id generated by the database, used to identify a WS
//	uint32	NbPlayers;	// number of player for *this* LS, the total number of player for a shard is in the database
//	TServiceId	SId;		// unique service id used to identify the connection when a callback happen
//
//	
//
//	std::vector<CFrontEnd>	FrontEnds;	// frontends on the shard
//
//	// ��������Ҫͬ����
//	uint8	OpenState;
//	bool	Online;
//};


// Variables

extern CLog*				Output;

//extern std::vector<CShard>	Shards;

// Functions

sint findShardWithSId (NLNET::TServiceId sid);
sint findShard (sint32 shardId);

void displayShards ();
void displayUsers ();
sint findUser (uint32 Id);
void beep (uint freq = 400, uint nb = 2, uint beepDuration = 100, uint pauseDuration = 100);

/*
 * disconnectClient is true if we need to disconnect the client on connected on the login system (during the login process)
 * disconnectShard is true if we need to send a message to the shard to disconnect the client from the shard
 */
//void disconnectClient (CUser &user, bool disconnectClient, bool disconnectShard);



#endif // NL_LOGIN_SERVICE_H

/* End of login_service.h */