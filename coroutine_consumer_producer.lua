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

