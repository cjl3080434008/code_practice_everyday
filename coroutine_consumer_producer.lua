producer = coroutine.create(function ()
				while true do
					print("OK i am producing now")
					local x = io.read()
					send(x)
				end
			end)

function send(food)
	print("i have produced , please consume it")
	coroutine.yield(food)
end

function receive(prod)
	local status, food = coroutine.resume(prod)
	print("i have receive and will consume ")
	return food
end

consumer = coroutine.create(function (prod)
				while true do
					local food = receive(prod)
					io.write(food, "\n")
					print("i have consumed, please produce again")
				end
			end)

coroutine.resume(consumer, producer)

--[[
--	
--	用coroutine实现一个生产者消费者：
--	（1）生产者是一个coroutine —      
--	     producer = coroutine.create(function ()
--	                              while true do
--	                                                            local food = io.read()
--	                                                                                          send(food)
--	                                                                                                                   end // while
--	                                                                                                                                       end // function)
--
--
--	                                                                                                                                         (2) 在发送的时候需要yield暂停生产者的生产
--	                                                                                                                                              function send(food)
--	                                                                                                                                                             coroutine.yield(food)
--	                                                                                                                                                                  end
--
--
--	                                                                                                                                                                    (3) 接受，消费者的前端，由它负责唤醒生产者让它开始生产
--	                                                                                                                                                                              function receive(producer)
--	                                                                                                                                                                                                  local status, value = coroutine.resume(producer)
--	                                                                                                                                                                                                                      return value
--	                                                                                                                                                                                                                                end
--
--
--	                                                                                                                                                                                                                                  (4) 消费者：也要是个coroutine
--	                                                                                                                                                                                                                                            consumer = coroutine.create(function (producer)
--	                                                                                                                                                                                                                                                                            while true do
--	                                                                                                                                                                                                                                                                                                               local food = receive(producer)
--	                                                                                                                                                                                                                                                                                                                                                  // filter函数可以加这里（*）
--	                                                                                                                                                                                                                                                                                                                                                                                     io.write(food, “\n”)
--	                                                                                                                                                                                                                                                                                                                                                                                                                     end
--	                                                                                                                                                                                                                                                                                                                                                                                                                                                   end)
--	                                                                                                                                                                                                                                                                                                                                                                                                                                                         最后调用 coroutine.resume(consumer, producer)
--	                                                                                                                                                                                                                                                                                                                                                                                                                                                         //  如书上所说，中间还可以加一个filter对food进行加工
--	                                                                                                                                                                                                                                                                                                                                                                                                                                                         filter可以是一个加工函数加入到(*).
--	                                                                                                                                                                                                                                                                                                                                                                                                                                                         filter也可以是一个coroutine它负责调用producer的coroutine来获得food加工然后又调用send发出，相当于两次send。 然后consumer只是一个普通的函数接受这个filter coroutine然后唤醒它让他开始工作源源不断的获取food进行consume.
--
--
--]]--
