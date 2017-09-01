module Admin::TaskHelper
	
	def initialize_charts(tasks)
		puts 'chartsssss'
		chart = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(text: "User Task Details")
		  f.xAxis(categories: ["New", "In Progress", "Completed", "Expired", "Pending Approved", "Completed and Approved "])
		  f.series(name: "No. of Users", yAxis: 0, data: [tasks.where(:status=>1).size, tasks.where(:status=>2).size, tasks.where(:status=>3).size, tasks.where(:status=>4).size, tasks.where(:status=>5).size, tasks.where(:status=>6).size])

		  f.yAxis [
		    {title: {text: "Total Task", margin: 70} },
		  ]

		  f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -100, layout: 'vertical')
		  f.chart({defaultSeriesType: "column"})
		end
		return chart
	end
	def chart_globals
		puts 'arar'
		chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
		  f.global(useUTC: false)
		  f.chart(
		    backgroundColor: {
		      linearGradient: [0, 0, 500, 500],
		      stops: [
		        [0, "rgb(255, 255, 255)"],
		        [1, "rgb(240, 240, 255)"]
		      ]
		    },
		    borderWidth: 2,
		    plotBackgroundColor: "rgba(255, 255, 255, .9)",
		    plotShadow: true,
		    plotBorderWidth: 1
		  )
		  f.lang(thousandsSep: ",")
		  f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
		end  
		chart_globals
	end
end