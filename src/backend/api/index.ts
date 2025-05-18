import { TypeBoxTypeProvider } from "@fastify/type-provider-typebox";
import fastify from "fastify";
import luau from "./luau";

const instance = fastify({ logger: true }).withTypeProvider<TypeBoxTypeProvider>();

export type instance = typeof instance;

const GlobalOption = {
    ApiPrefix: {
        Rbxm: {
            GuiObject: '/api/rbxm/gui-object',
        },
    },
};

instance.decorate('GlobalOption', GlobalOption);

export type GlobalOptions = typeof GlobalOption;

declare module 'fastify' {
	interface FastifyInstance {
		GlobalOptions: GlobalOptions
	}
}

luau();

export default instance;

