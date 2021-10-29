class Shotyu < Alcohol
    # Alcoholを使うポリモーフィックなモデルはAlcoholableをincludeする
    include Alcoholable
    
    # moduleで定義されているメソッドをオーバーライドする
    
     def name
        return "beer"
        raise NotImplementedError
      end
    
      def description
                return "とりあえずビール"
        raise NotImplementedError
      end
    
      def alcohol_percentage
                return 5
        raise NotImplementedError
      end
    
      def alcohol_amount
                return 350
        raise NotImplementedError
      end
    
      def pure_alcohol_intake
                return 14
        raise NotImplementedError
      end
    end