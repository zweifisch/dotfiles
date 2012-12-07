var statusbardate = 
{

	position : 4,//显示位置可修改
	timezone : 15, //为本地时间
	format : "[%H:%i %n/%j]", //日期格式可修改
	TimeId :null,
	TextShow :true ,
	clock : function( element )
	{
		

		var dateTime = this.format;
		var date = this.calculateDate(this.timezone);
		
		
		dateTime = dateTime.replace( /%d/g, this.leadingZero( date.getDate() ) );
		
		dateTime = dateTime.replace( /%j/g, date.getDate() );
		dateTime = dateTime.replace( /%m/g, this.leadingZero( date.getMonth() + 1 ) );
		dateTime = dateTime.replace( /%n/g, date.getMonth() + 1 );
		dateTime = dateTime.replace( /%Y/g, date.getYear() + 1900 );
		dateTime = dateTime.replace( /%y/g, this.leadingZero( date.getYear() + 1900 - 2000 ) );
		dateTime = dateTime.replace( /%g/g, this.convertTo12Hour( date.getHours() ) );
		dateTime = dateTime.replace( /%G/g, date.getHours() );
		dateTime = dateTime.replace( /%h/g, this.leadingZero( this.convertTo12Hour( date.getHours() ) ) );
		
		dateTime = dateTime.replace( /%H/g, this.leadingZero( date.getHours() ) );
		dateTime = dateTime.replace( /%i/g, this.leadingZero( date.getMinutes() ) );
		dateTime = dateTime.replace( /%s/g, this.leadingZero( date.getSeconds() ) );
		dateTime = dateTime.replace( /%a/g, this.amPm( date.getHours(), false ) );
		dateTime = dateTime.replace( /%A/g, this.amPm( date.getHours(), true ) );
			
		dateTime = dateTime.replace( /%D/g, this.textualWeekday( date.getDay(), true ) );
		dateTime = dateTime.replace( /%L/g, this.textualWeekday( date.getDay(), false ) );
	
		dateTime = dateTime.replace( /%M/g, this.textualMonth( date.getMonth(), true ) );
		dateTime = dateTime.replace( /%F/g, this.textualMonth( date.getMonth(), false ) );
			
		dateTime = dateTime.replace( /%J/g, this.julianDate( date ) );

	
		element.label = dateTime;
			
		this.TimeId = window.setTimeout( function() { statusbardate.clock( element ); }, 500 );	
	},
	
	changePosition :function()
	{
		if ( this.position < 1 )
			return;			
		var statusable = true;
		var parent = document.getElementById( "statusbardate-statusbarpanel" ).parentNode.getAttribute("id");
		parent = document.getElementById( parent );
		
		if ( !document.getElementById( "statusablebar" ) )
				statusable = false;
		
		var statusBar;
		if ( statusable )
			statusBar = document.getElementById( "statusablebar" );
		else
			statusBar = document.getElementById( "status-bar" );
			
		var children = statusBar.childNodes;
		
		var statusbarItem = document.getElementById( "statusbardate-statusbarpanel" );
		var newStatusbarItem = parent.removeChild( statusbarItem );
		
		if ( ( children.length == 0 ) || ( this.position >= children.length ) )
			statusBar.appendChild(newStatusbarItem);
		else
			statusBar.insertBefore( newStatusbarItem, children[ this.position - 1 ] );
	},
	//----------------------------------------------------------------------------------------------------------------------------------		
	calculateDate : function( timezoned )
	{
	
		if ( timezoned == 15 )
			return new Date();
			
		// create Date object for current location
		var d = new Date();
		
		// convert to msec since Jan 1 1970
		var localTime = d.getTime();
		
		// obtain local UTC offset and convert to msec
		var localOffset = d.getTimezoneOffset() * 60000;
		
		// obtain UTC time in msec
		var utc = localTime + localOffset;
		
		// obtain and add destination's UTC time offset
		var destinationTime = utc + ( 3600000 * timezoned );
		
		return new Date( destinationTime ); 
	},
	
	// Utility private methods
	//----------------------------------------------------------------------------------------------------------------------------------		
	leadingZero : function( i )
	{
		if ( i < 10 )
			i = "0" + i;
		return i;
	},
	//----------------------------------------------------------------------------------------------------------------------------------		
	convertTo12Hour : function( hour )
	{
		if ( hour > 12 )
			return hour - 12;
		if ( hour == 0 )
			return 12;
		return hour;
	},
	//----------------------------------------------------------------------------------------------------------------------------------		
	amPm : function( hour, caps )
	{
		if ( hour < 12 )
			if ( caps )
				return "AM";
			else
				return "am";
		else
			if ( caps )
				return "PM";
			else
				return "pm";
	},
	//----------------------------------------------------------------------------------------------------------------------------------		
	textualWeekday : function( weekday, short )
	{
	//	var strbundle = document.getElementById("statusbardate-strings");

		var shortWeekday = new Array( 7 );
		//////////////////////////////////////星期
		shortWeekday[ 0 ] = 'Sun';
		shortWeekday[ 1 ] = 'Mon';
		shortWeekday[ 2 ] = 'Tue';
		shortWeekday[ 3 ] = 'Wed';
		shortWeekday[ 4 ] = 'Thu';
		shortWeekday[ 5 ] = 'Fri';
		shortWeekday[ 6 ] = 'Sat';
		
		var fullWeekday = new Array( 7 );
		fullWeekday[ 0 ] = 'Sunday';
		fullWeekday[ 1 ] = 'Monday';
		fullWeekday[ 2 ] = 'Tuesday';
		fullWeekday[ 3 ] = 'Wednesday';
		fullWeekday[ 4 ] = 'Thursday';
		fullWeekday[ 5 ] = 'Friday';
		fullWeekday[ 6 ] = 'Saturday';
				
		if ( short )
			return shortWeekday[ weekday ];
		else
			return fullWeekday[ weekday ];
	},
	//----------------------------------------------------------------------------------------------------------------------------------		
	textualMonth : function( month, short )
	{
		//var strbundle = document.getElementById("statusbardate-strings");
		
		var shortMonth = new Array( 12 );
		////////////////////////////////////////月份
		shortMonth[ 0 ] = 'Jan';
		shortMonth[ 1 ] = 'Feb';
		shortMonth[ 2 ] = 'Mar';
		shortMonth[ 3 ] = 'Apr';
		shortMonth[ 4 ] = 'May';
		shortMonth[ 5 ] = 'Jun';
		shortMonth[ 6 ] = 'Jul';
		shortMonth[ 7 ] = 'Aug';
		shortMonth[ 8 ] = 'Sep';
		shortMonth[ 9 ] = 'Oct';
		shortMonth[ 10 ] = 'Nov';
		shortMonth[ 11 ] = 'Dec';
		
		var fullMonth = new Array( 12 );
		fullMonth[ 0 ] = 'January';
		fullMonth[ 1 ] = 'February';
		fullMonth[ 2 ] = 'March';
		fullMonth[ 3 ] = 'April';
		fullMonth[ 4 ] = 'May';
		fullMonth[ 5 ] = 'June';
		fullMonth[ 6 ] = 'July';
		fullMonth[ 7 ] = 'August';
		fullMonth[ 8 ] = 'September';
		fullMonth[ 9 ] = 'October';
		fullMonth[ 10 ] = 'November';
		fullMonth[ 11 ] = 'December';
		
		if ( short )
			return shortMonth[ month ];
		else
			return fullMonth[ month ];
	},
	//----------------------------------------------------------------------------------------------------------------------------------
	isLeapYear : function(y) {
       // check to to see if the year is divisible by 4 and therefore a Leap Year
	if (y%4==0) {
		if (y%100==0) return (y%400==0)?true:false;
		return true;
	}
	return false;
	},

	julianDate : function( date )
	{		
		var days = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		var julianDate = 0;
	 
		// if leap year add + 1 day to february days value
		if ( this.isLeapYear( date.getFullYear() ) ) 
			days[1] += 1;
		
		for ( var i = 0; i < date.getMonth(); i++ ) 
			julianDate += days[i];
			
		julianDate += date.getDate();
				
		return julianDate;
	},
	
	statusControl : function()
	{
		var statusbar = document.getElementById( 'statusbardate-statusbarpanel' );
		
		
		this.clock( statusbar );
		
	
	},
	changeShow : function(){
	var statusbar = document.getElementById( 'statusbardate-statusbarpanel' );
	if(this.TextShow)
	{
		
		clearTimeout(this.TimeId);
		statusbar.label = "Date";//不显示时间的文字
		this.TextShow = false ;
		return;
		}else{
		this.clock(statusbar);
		this.TextShow = true ;
		}
	}
	
};
//----------------------------------------------------------------------------------------------------------------------------------
(function(){

var statusbardate1=document.createElement("statusbarpanel");
statusbardate1.setAttribute("id","statusbardate-statusbarpanel");


statusbardate1.setAttribute("onclick","statusbardate.changeShow()");
statusbardate1.setAttribute("class","statusbarpanel-text");


var statusbarW = document.getElementById("status-bar");
statusbarW.appendChild(statusbardate1);

if(statusbardate1)
{
	
	statusbardate.changePosition();
	statusbardate.statusControl(); 
}
})();
