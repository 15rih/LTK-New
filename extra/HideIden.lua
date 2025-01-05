function BuyHood()
            local args = {
                [1] = "Buy",
                [2] = "Hats",
                [3] = "Hood"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end
        function EquipHood()
            local args = {
                [1] = "Wear",
                [2] = "Hats",
                [3] = "Hood"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end
        function BuyShirt()
            local args = {
                [1] = "Buy",
                [2] = "Shirts",
                [3] = "Amiri Star Hoodie"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end
        function EquipShirt()
            local args = {
                [1] = "Wear",
                [2] = "Shirts",
                [3] = "Amiri Star Hoodie"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end  
        function BuyPants()
            local args = {
                [1] = "Buy",
                [2] = "Pants",
                [3] = "Amiri Jeans x Grey b22"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end
        function EquipPants()
            local args = {
                [1] = "Wear",
                [2] = "Pants",
                [3] = "Amiri Jeans x Grey b22"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end    
        function BuyShades()
            local args = {
                [1] = "Buy",
                [2] = "Glasses",
                [3] = "BlackShades"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end
        function EquipShades()
            local args = {
                [1] = "Wear",
                [2] = "Glasses",
                [3] = "BlackShades"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end    
        function BuyShiesty()
            local args = {
                [1] = "Buy",
                [2] = "Shiestys",
                [3] = "Shiesty"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end   
        function EquipShiesty()
            local args = {
                [1] = "Wear",
                [2] = "Shiestys",
                [3] = "Shiesty"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ClothShopRemote"):FireServer(unpack(args))
        end    
        
        BuyHood()
        EquipHood() 
        task.wait(0.1)
        BuyShirt()
        EquipShirt()
        task.wait(0.1)
        BuyPants()
        EquipPants()
        task.wait(0.1)
        BuyShades()
        EquipShades()
        task.wait(0.1)
        BuyShiesty()
        EquipShiesty()
