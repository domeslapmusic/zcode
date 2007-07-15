import tv.zarate.Utils.Delegate;

import tv.zarate.Projects.zplayer.Player;
import tv.zarate.Projects.zplayer.zpVideo;
import tv.zarate.Projects.zplayer.Item;

class tv.zarate.Projects.zplayer.PlayerVideo extends Player{

	private var video_mc:MovieClip;
	private var videoObj:Video;
	private var stream_ns:NetStream;
	private var connection_nc:NetConnection;
	private var sound:Sound;
	private var videoDuration:Number = 0;

	public function PlayerVideo(video:Item,base_mc:MovieClip){

		super(video,base_mc);

	}

	public function playItem():Void{

		clearConnection();

		connection_nc = new NetConnection();
		connection_nc.connect(null);

		stream_ns = new NetStream(connection_nc);

		video_mc = base_mc.attachMovie("VideoDisplay","video_mc",100);
		videoObj = video_mc.video;

		videoObj.attachVideo(stream_ns);

		stream_ns.onStatus = Delegate.create(this,statusHandler);
		stream_ns.onMetaData = Delegate.create(this,setMetaData);

		video_mc._width = width;
		video_mc._height = height;

		stream_ns.play(item.url);

		//sound = new Sound(timeLine_mc);
		//set_volume(currentVolume);

	}

	public function remove():Void{

		super.remove();
		clearConnection();

	}

	// **************** PRIVATE METHODS ****************

	private function clearConnection():Void{

		if(connection_nc != null){

			connection_nc.close();
			stream_ns.play(null);
			stream_ns.close();

			delete connection_nc;
			delete stream_ns;

		}

	}

	private function setMetaData(stream:Object):Void{

		for(var x:String in stream){
			//trace('1 : ' + stream[x] )
		}

		videoDuration = stream.duration;
		//view.setVideoDuration(videoDuration);

	}

	private function statusHandler(infObj:Object){

		for(var x:String in infObj){
			//trace('2 : ' + infObj[x] )
		}

	}

}