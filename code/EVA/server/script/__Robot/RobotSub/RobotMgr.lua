RobotMgr = {}

function RobotMgr:Init()
	
	self._EventRegister = EventRegister.new();
    -- 线程间消息
	self._EventRegister:RegisterEvent( "TestSubProc",  self, self.LuaTestCB );


    -- 网络消息
    self._EventRegister:RegisterEvent( "AuthOk",            self, self.cbAuthOk );
    self._EventRegister:RegisterEvent( "SyncPlayerInfo",    self, self.cbSyncPlayerInfo );

    -- 斗地主消息
    self._EventRegister:RegisterEvent( "DDZ_GI",            self, self.cbDdzGameInfo );
    self._EventRegister:RegisterEvent( "DDZ_SR",            self, self.cbDdzUserStartReady );
    self._EventRegister:RegisterEvent( "DDZ_QDZ_QX",        self, self.cbDDZ_QDZ_QX );
    
    
    
    

    self.TotalRobot         = nil;
    self.RobotList          = {};
    self.PrintFilterWhite   = {};
    
    self.MsgNames           = {};
end

function RobotMgr:StartLogic( start_num, total_num )
	
    self.PrintFilterWhite[1007] = true;
    
    self.TotalRobot = total_num;

    for i=1,total_num do
        local robot                         = Robot:new();
        robot.Data.User                     = "test_" .. start_num+i-1;
        robot.Data.Game                     = "RM_DDZ";

        robot:Init(i);
        self.RobotList[robot:GetHandle()]   = robot;
    end
end

function RobotMgr:RegisterMsg( msgname, callbackname )
    if self.MsgNames[msgname]==nil then
        self._EventRegister:RegisterEvent( msgname,            self, self.DispatchMsg );
        self.MsgNames[msgname] = callbackname;
    end
end

function RobotMgr:DispatchMsg( from, msgin )
    
    local robot = self.RobotList[from];
    if robot~=nil then
        --robot.Game:cbXXX(msgin);
    end
end


function RobotMgr:Update()
    for _,v in pairs(self.RobotList) do
        v:Update();
    end
end

function RobotMgr:Print( str, id )
    if self.PrintFilterWhite==nil then
        nlinfo(str);
    else
        if self.PrintFilterWhite[id]~=nil then
            nlinfo(str);
        end
    end
end

function RobotMgr:PrintTable( tbl, id )
    if (#self.PrintFilterWhite)==0  then
        PrintTable(tbl);
    else
        if self.PrintFilterWhite[id]~=nil then
            PrintTable(tbl);
        end
    end
end

function RobotMgr:Release()
    
end

function RobotMgr:LuaTestCB( from, msgin )

	local msgint  = msgin:rint();
    local msgstr  = msgin:rstring();
	
	nlinfo(from);
	nlinfo(msgint);
	nlinfo(msgstr);
    
    
    local msgout = CMessage("TestMainProc");
    msgout:wstring("TestMainProc");
	Misc.PostMain( G_ThreadHandle, msgout );
end

function RobotMgr:cbAuthOk( from, msgin )
    local robot = self.RobotList[from];
    if robot~=nil then
        nlinfo("RobotMgr:cbAuthOk");
    end
end

function RobotMgr:cbSyncPlayerInfo( from, msgin )
    local robot = self.RobotList[from];
    if robot~=nil then
        robot:cbSyncPlayerInfo(msgin);
    end
end

function RobotMgr:cbDdzGameInfo( from, msgin )
    local robot = self.RobotList[from];
    if robot~=nil then
        robot.Game:cbDdzGameInfo(msgin);
    end
end

function RobotMgr:cbDdzUserStartReady( from, msgin )
    local robot = self.RobotList[from];
    if robot~=nil then
        robot.Game:cbDdzUserStartReady(msgin);
    end
end

function RobotMgr:cbDDZ_QDZ_QX( from, msgin )
    local robot = self.RobotList[from];
    if robot~=nil then
        robot.Game:cbDDZ_QDZ_QX(msgin);
    end
end


return RobotMgr;
